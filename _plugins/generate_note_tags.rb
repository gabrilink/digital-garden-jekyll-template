module Jekyll
  class NoteTagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        all_tags = site.collections['notes'].docs.flat_map { |doc| doc.data['tags'] || [] }.uniq

        all_tags.each do |tag|
          site.pages << NoteTagPage.new(site, site.source, tag)
        end
      end
    end
  end

  class NoteTagPage < Page
    def initialize(site, base, tag)
      @site = site
      @base = base
      @dir  = "tags/#{tag}"
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Notes tagged: #{tag}"
    end
  end
end
