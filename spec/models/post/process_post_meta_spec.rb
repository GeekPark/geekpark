require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'extract pictures correctly' do
    content_md = <<~EOF
    ![foo](https://httpbin.org/image/jpeg)
    ![](https://httpbin.org/image/png)
    [![bar](https://httpbin.org/image/jpeg)](https://google.com)
    EOF
    tushang_post = create(:post,
                          column: SiteConfig.columns.tushang,
                          content_source: content_md,
                          content_type: :markdown)

    settings = tushang_post.settings
    expect(settings.count).not_to eq(0)
    expect(settings.picture_sources).to \
      eq(['https://httpbin.org/image/jpeg',
          'https://httpbin.org/image/png',
          'https://httpbin.org/image/jpeg'])
    expect(settings.picture_titles).to eq(['foo', '', 'bar'])
  end

  it 'extract headings correctly' do
    content_md = <<~EOF
    ## f<strong>o</strong>o?
    hello
    ## bar!
    world
    EOF

    zaozhidao_post = create(:post,
                            column: SiteConfig.columns.zaozhidao,
                            content_source: content_md,
                            content_type: :markdown)

    settings = zaozhidao_post.settings
    expect(settings.count).not_to eq(0)
    expect(settings.headings).to eq(%w(foo? bar!))
  end

  it 'normal post does not contain these settings' do
    post = create(:post)
    settings = post.settings
    expect(settings.headings).to be_nil
    expect(settings.picture_sources).to be_nil
    expect(settings.picture_titles).to be_nil
  end
end
