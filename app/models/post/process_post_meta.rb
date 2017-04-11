module Post::ProcessPostMeta
  extend ActiveSupport::Concern

  included do
    include RailsSettings::Extend

    after_save :process_zaozhidao_headings,
               if: -> { column_id == SiteConfig.columns.zaozhidao.id }
    after_save :process_tushang_pictures,
               if: -> { column_id == SiteConfig.columns.tushang.id   }
  end

  private

  def content_dom
    @content_dom ||= Nokogiri::HTML(content)
  end

  def process_zaozhidao_headings
    headings = content_dom.xpath('//h2')
    settings.headings = headings.map { |x| x.text }
    settings.save
  end

  def process_tushang_pictures
    imgs = content_dom.xpath('//img[@src]')
    settings.picture_sources = imgs.map { |x| x['src']   }
    settings.picture_titles  = imgs.map { |x| x['title'] || x['alt'] }
  end
end
