require "active_record/relation"
require "active_support/concern"

require "virtual_aliases/version"
require "virtual_aliases/relation"

ActiveRecord::Relation.send(:include, VirtualAliases::Relation)

