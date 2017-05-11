module API::V1::Admin
  class ImagesController < AdminController
    resource_description { short '圖片上傳相關 API' }

    api :POST, '/admin/images', 'Create an image'
    param :upload_file, String, required: true,
          desc: '請使用 multipart 內容類別上傳圖片'
    param :usage, ['post_cover'], desc: '可選用途，可自訂'
    def create
      success do
        Image.create!(file: params[:upload_file],
                      usage: params[:usage])
      end
    end
  end
end
