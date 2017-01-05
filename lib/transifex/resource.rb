module Transifex
  class Resource
    attr_accessor :client, :category, :i18n_type, :source_language_code, :slug, :name

    def initialize(project_slug, transifex_data)
      @project_slug = project_slug
      @name = transifex_data[:name]
      @category = transifex_data[:category]
      @i18n_type = transifex_data[:i18n_type]
      @source_language_code = transifex_data[:source_language_code]
      @slug = transifex_data[:slug]
    end

    def content
      client.get("/project/#{@project_slug}/resource/#{@slug}/content/")
    end

    def translation(lang)
      client.get("/project/#{@project_slug}/resource/#{@slug}/translation/#{lang}/")
    end

    def stats(lang)
      stats = client.get("/project/#{@project_slug}/resource/#{@slug}/stats/#{lang}")
      Transifex::Stats.new(stats).tap {|r| r.client = client }
    end

    def update_content(content)
      client.put(
        "/project/#{@project_slug}/resource/#{@slug}/content/",
        {content: content.to_json}.to_json
      )
    end
  end
end
