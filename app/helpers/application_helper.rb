module ApplicationHelper

    # a customized out link function, can add prefix to the weblink
    def link_to_external_lookup(options={})
        #url_prefix = 'https://www.google.com/search?q='
        options[:value].map do |url|
            link_to "#{url}", "#{url}"
        end
    end
end
