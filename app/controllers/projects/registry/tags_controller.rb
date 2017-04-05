module Projects
  module Registry
    class TagsController < ::Projects::Registry::ApplicationController
      before_action :authorize_update_container_image!, only: [:destroy]

      def destroy
        if tag.delete
          redirect_to project_container_registry_path(@project),
                      notice: 'Registry tag has been removed successfully!'
        else
          redirect_to project_container_registry_path(@project),
                      alert: 'Failed to remove registry tag!'
        end
      end

      private

      def repository
        @image ||= project.container_repositories
          .find(params[:repository_id])
      end

      def tag
        return render_404 unless params[:id].present?

        @tag ||= repository.tag(params[:id])
      end
    end
  end
end
