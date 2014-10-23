module VirtualAliases
  class Error < StandardError; end

  module Relation
    extend ActiveSupport::Concern

    def valiases(*args)
      spawn.valiases!(*args)
    end

    def valiases!(*args)
      args.reject!(&:blank?)
      args.flatten!

      self.valiases_values = args.first
      self
    end

    def valiases_values=(values)
      @valiases = values
    end

    def valiases_values
      @valiases
    end

    def arel
      return @arel if @arel

      if @valiases
        # now do the magic stuff

        valiases_joins = ActiveRecord::Associations::JoinDependency.new(@klass, valiases_values ,[])

        keypaths = association_keypaths( valiases_joins )

        # now add the left joins to this relation
        self.joins!( valiases_joins )

        # call the standard AR::Relation to AREL function
        @arel = build_arel

        Arel::Visitors::DepthFirst.new(lambda {|n|
                                         case(n)
                                           when Arel::Nodes::SqlLiteral
                                             n.gsub!(/\{(.*?)\}/) { |vfield|
                                               if $1 =~ /^([^.]*)$|^(.*)\.(.*)$/
                                                 if $1
                                                   real_aliased_field = "%s.%s" % [@klass.connection.quote_table_name(keypaths[virtual_alias]),@klass.connection.quote_column_name($1)]
                                                 elsif $2 and $3
                                                   if keypaths[$2]
                                                     real_aliased_field = "%s.%s" % [@klass.connection.quote_table_name(keypaths[$2]),@klass.connection.quote_column_name($3)]
                                                   else
                                                     raise Error, "virtual alias #{$2} not found!"
                                                   end
                                                 else
                                                   raise Error, "virtual alias #{$1} can't be parsed!"

                                                 end
                                               else
                                                 raise Error, "virtual alias #{vfield} can't be parsed!"
                                               end
                                               real_aliased_field
                                             }
                                         end
                                       }).accept(@arel.ast)

        @arel
      else
        super
      end

    end

    private

    def association_keypaths( join_dependency )
      keypaths ||={}

      _build = lambda { | join_parts , base_alias |
        join_parts.each { | child_join_part |
          if child_join_part.respond_to? :reflection
            child_alias = [base_alias,child_join_part.name.to_s].compact.join('.')
            keypaths[child_alias] = child_join_part.aliased_table_name
          end
          _build.call( child_join_part.children, child_alias )
        }
      }

      base_alias = join_dependency.join_root.base_klass.model_name.singular.to_s
      keypaths[base_alias] = join_dependency.join_root.aliased_table_name

      _build.call( join_dependency.join_root.children, nil )

      keypaths
    end

  end

end


