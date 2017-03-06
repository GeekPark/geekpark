module MarkdownEngine
  def self.render_html(md_text)
    engine.render(md_text)
  end

  def self.render_text(md_text)
    engine(stripdown_renderer).render(md_text)
  end

  class << self
    def engine(renderer = html_renderer)
      @markdown ||= Redcarpet::Markdown.new(
        renderer,
        autolink: true,
        tables: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true,
        underline: true,
        footnote: true
      )
    end

    def html_renderer
      Redcarpet::Render::HTML
    end

    def stripdown_renderer
      Redcarpet::Render::StripDown
    end
  end
end
