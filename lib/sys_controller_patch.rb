require_dependency 'sys_controller'

module SysControllerPatch

    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
            alias_method :fetch_changesets_without_by_root_url, :fetch_changesets
            alias_method :fetch_changesets, :fetch_changesets_with_by_root_url
        end
    end

    module ClassMethods
    end

    module InstanceMethods

        def fetch_changesets_with_by_root_url
            unless params[:root_url]
                return fetch_changesets_without_by_root_url
            end

            repositories = Repository.where(root_url: params[:root_url].to_s)

            unless repositories
                head :not_found
            end

            for repository in repositories
                repository.fetch_changesets
                Rails.logger.info "fetched changesets for " + repository.root_url
            end

            head :ok
        end

    end

end
