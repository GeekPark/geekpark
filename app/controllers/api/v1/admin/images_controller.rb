module API::V1::Admin
  class ImagesController < AdminController
    def create
      success do
        Image.create!(file: params[:upload_file],
                      usage: params[:usage])
      end
    end
  end
end
