# Contributing to virtual_aliases

First off, if you experience a bug, we welcome you to report it. Please provide a minimal test case showing the code that you ran, its output, and what you expected the output to be instead. If you are able to fix the bug and make a pull request, we are much more likely to get it resolved quickly, but don't feel bad to just report an issue if you don't know how to fix it.

virtual_aliases supports Ruby 1.9.2 and higher, Active Record 3.1 and higher. It can be hard to test against all of those versions, but please do your best to avoid features that are only available in newer versions. For example, don't use Ruby 2.0's `prepend` keyword.

Go ahead and make a pull request.

Run the tests by running rake. It will update all gems to their latest version. This is by design, because we want to be proactive about compatibility with other libraries. To test against a specific version of Active Record, you can set the `ACTIVE_RECORD_VERSION` environment variable.

    $ ACTIVE_RECORD_VERSION=3.1 rake
