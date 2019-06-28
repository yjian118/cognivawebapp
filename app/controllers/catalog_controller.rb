# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Blacklight::Marc::Catalog


  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response
    #
    ## Should the raw solr document endpoint (e.g. /catalog/:id/raw) be enabled
    # config.raw_endpoint.enabled = false

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 10
    }

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'
    #config.document_solr_path = 'get'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    # solr field configuration for search results/index views
    config.index.title_field = 'id'
    #config.index.title_field = 'title_tsim'
    #config.index.display_type_field = 'format'
    #config.index.thumbnail_field = 'thumbnail_path_ss'
    #bookmark_control may probablely control the behavior of add books to the shopping cart
    #config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

    #config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    #config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    #config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    #config.add_show_tools_partial(:citation)

    #config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')

    # solr field configuration for document/show views
    #config.show.title_field = 'title_tsim'
    #config.show.display_type_field = 'format'
    #config.show.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view to have facet prefix-based navigation
    #  (useful when user clicks "more" on a large facet and wants to navigate alphabetically across a large set of results)
    # :index_range can be an array or range of prefixes that will be used to create the navigation (note: It is case sensitive when searching values)

    config.add_facet_field 'document_genre_tsim', label: 'Document Genre'
    config.add_facet_field 'qApplication_ssim', label: 'Application'
    config.add_facet_field 'qDate_ssim', label: 'Create Time', limit: 30
    #:date => true
    #label: 'Time Period', :query => {
    #  :years_5 => { label: 'within 6 month', fq: "qDate_ssim:[#{Time.zone.now.month - 6 } TO *]" },
    #  :years_10 => { label: 'within 1 Year', fq: "qDate_ssim:[#{Time.zone.now.month - 12 } TO #{Time.zone.now.month - 6 } ]" },
    #  :years_25 => { label: 'over 1 Year', fq: "qDate_ssim:[* TO #{Time.zone.now.month - 12 } ]" }
    #}
    config.add_facet_field 'accounts_ssim', label: 'Accounts Status'
    config.add_facet_field 'author_ssim', label: 'Author', :sort => 'index', limit: 20
    config.add_facet_field 'calendar_year_ssim', label: 'Calendar Year'
    config.add_facet_field 'client_name_ssim', label: 'Client', :sort => 'index'
    config.add_facet_field 'client_reference_no_ssim', label: 'Client No.'
    config.add_facet_field 'company_expenses_ssim', label: 'Company Expense'
    config.add_facet_field 'description_ssim', label: 'Description'
    config.add_facet_field 'destination_ssim', label: 'Destination'
    config.add_facet_field 'document_type1_ssim', label: 'Document Type'
    config.add_facet_field 'document_type_ssim', label: 'Document Type'
    config.add_facet_field 'employee_name_ssim', label: 'Employee Name'
    config.add_facet_field 'fiscal_year_ssim', label: 'Fiscal Year'
    config.add_facet_field 'function_ssim', label: 'Function'
    config.add_facet_field 'granting_agency_ssim', label: 'Granting Agency', :sort => 'index'
    config.add_facet_field 'item_status_ssim', label: 'Item Status'
    config.add_facet_field 'multi_ssim', label: 'Multi'
    config.add_facet_field 'node_ssim', label: 'Node'
    config.add_facet_field 'position_ssim', label: 'Postion', :sort => 'index'
    config.add_facet_field 'privacy_ssim', label: 'Privacy'
    config.add_facet_field 'project_ssim', label: 'Project'
    config.add_facet_field 'project_deliverable_ssim', label: 'Project Deliverable'
    config.add_facet_field 'role_ssim', label: 'Role', :sort => 'index'
    config.add_facet_field 'text_ssim', label: 'Description'
    config.add_facet_field 'type_of_expense_ssim', label: 'Type of Expense'
    config.add_facet_field 'type_of_grant_ssim', label: 'Type of Grant'
    #config.add_facet_field 'pub_date_ssim', label: 'Publish Date', single: true
    #config.add_facet_field 'subject_ssim', label: 'Topic', limit: 20, index_range: 'A'..'Z'
    #config.add_facet_field 'language_ssim', label: 'Language', limit: true
    #config.add_facet_field 'lc_1letter_ssim', label: 'Call Number'
    #config.add_facet_field 'subject_geo_ssim', label: 'Region'
    #config.add_facet_field 'subject_era_ssim', label: 'Era'
    #config.add_facet_field 'author_ssim', label: 'Author'
    #config.add_facet_field 'department_ssim', label: 'Department'
    #config.add_facet_field 'position_ssim', label: 'Position'
    #config.add_facet_field 'role_ssim', label: 'Role'
    #config.add_facet_field 'Author', query: {
    #   a_to_n: { label: 'A-N', fq: 'author_tsim:[A* TO N*]' }
    #  m_to_z: { label: 'M-Z', fq: 'author_tsim:[M* TO Z*]' }
    #}
    # The author should be capitalize in some where
    # config.add_facet_field 'author_ssim', label: 'Author', limit:true, index_range: 'A'..'Z'
    config.add_facet_field 'author&client_pivot_field', label: 'Author & Client Pivot', 
      :pivot => ['author_ssim', 'client_name_ssim']

    config.add_facet_field 'author&position_pivot_field', label: 'Author & Position Pivot', 
      :pivot => ['author_ssim', 'position_ssim']

    config.add_facet_field 'author&role_pivot_field', label: 'Author & Role Pivot', 
      :pivot => ['author_ssim', 'role_ssim']
    #config.add_facet_field 'example_query_facet_field', label: 'Time Period', :query => {
    #   :years_5 => { label: 'within 5 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 5 } TO *]" },
    #   :years_10 => { label: 'within 10 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 10 } TO *]" },
    #   :years_25 => { label: 'within 25 Years', fq: "pub_date_ssim:[#{Time.zone.now.year - 25 } TO *]" }
    #}


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    #config.add_index_field 'title_tsim', label: 'Title'
    #config.add_index_field 'title_vern_ssim', label: 'Title'
    #config.add_index_field 'author_ssim', label: 'Author'
    #config.add_index_field 'author_vern_ssim', label: 'Author'
    #config.add_index_field 'format', label: 'Format'
    #config.add_index_field 'language_ssim', label: 'Language'
    #config.add_index_field 'published_ssim', label: 'Published'
    #config.add_index_field 'published_vern_ssim', label: 'Published'
    #config.add_index_field 'pub_date_ssim', label: 'Publish Date'
    #config.add_index_field 'department_ssim', label: 'Department'
    #config.add_index_field 'role_ssim', label: 'Role'
    #config.add_index_field 'position_ssim', label: 'Position'
    #config.add_index_field 'isbn_tsim', label: 'ISBN'
    #config.add_index_field 'lc_callnum_ssim', label: 'Call number'
    config.add_index_field 'accounts_ssim', label: 'Accounts Status'
    config.add_index_field 'author_ssim', label: 'Author'
    config.add_index_field 'calendar_year_ssim', label: 'Calendar Year'
    config.add_index_field 'client_name_ssim', label: 'Client'
    config.add_index_field 'client_reference_no_ssim', label: 'Client No.'
    config.add_index_field 'company_expenses_ssim', label: 'Company Expense'
    config.add_index_field 'description_ssim', label: 'Description'
    config.add_index_field 'destination_ssim', label: 'Destination'
    config.add_index_field 'document_type1_ssim', label: 'Document Type'
    config.add_index_field 'document_type_ssim', label: 'Document Type'
    config.add_index_field 'employee_name_ssim', label: 'Employee Name'
    config.add_index_field 'fiscal_year_ssim', label: 'Fiscal Year'
    config.add_index_field 'function_ssim', label: 'Function'
    config.add_index_field 'granting_agency_ssim', label: 'Granting Agency'
    config.add_index_field 'item_status_ssim', label: 'Item Status'
    config.add_index_field 'multi_ssim', label: 'Multi'
    config.add_index_field 'node_ssim', label: 'Node'
    config.add_index_field 'position_ssim', label: 'Postion'
    config.add_index_field 'privacy_ssim', label: 'Privacy'
    config.add_index_field 'project_ssim', label: 'Project'
    config.add_index_field 'project_deliverable_ssim', label: 'Project Deliverable'
    config.add_index_field 'role_ssim', label: 'Role'
    config.add_index_field 'text_ssim', label: 'Description'
    config.add_index_field 'type_of_expense_ssim', label: 'Type of Expense'
    config.add_index_field 'type_of_grant_ssim', label: 'Type of Grant'
    config.add_index_field 'url_fulltext_ssm', label: 'URL'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    #config.add_show_field 'title_tsim', label: 'Title'
    #config.add_show_field 'title_vern_ssim', label: 'Title'
    #config.add_show_field 'subtitle_tsim', label: 'Subtitle'
    #config.add_show_field 'subtitle_vern_ssim', label: 'Subtitle'
    #config.add_show_field 'author_ssim', label: 'Author'
    #config.add_show_field 'author_vern_ssim', label: 'Author'
    #config.add_show_field 'format', label: 'Format'
    #config.add_show_field 'url_suppl_ssim', label: 'More Information'
    #config.add_show_field 'language_ssim', label: 'Language'
    #config.add_show_field 'published_ssim', label: 'Published'
    #config.add_show_field 'published_vern_ssim', label: 'Published'
    #config.add_show_field 'pub_date_ssim', label: 'Publish Date'
    #config.add_show_field 'lc_callnum_ssim', label: 'Call number'
    #config.add_show_field 'isbn_tsim', label: 'ISBN'
    #config.add_show_field 'department_ssim', label: 'Department'
    #config.add_show_field 'role_ssim', label: 'Role'
    #config.add_show_field 'position_ssim', label: 'Position'
    config.add_show_field 'accounts_ssim', label: 'Accounts Status'
    config.add_show_field 'author_ssim', label: 'Author'
    config.add_show_field 'calendar_year_ssim', label: 'Calendar Year'
    config.add_show_field 'client_name_ssim', label: 'Client'
    config.add_show_field 'client_reference_no_ssim', label: 'Client No.'
    config.add_show_field 'company_expenses_ssim', label: 'Company Expense'
    config.add_show_field 'description_ssim', label: 'Description'
    config.add_show_field 'destination_ssim', label: 'Destination'
    config.add_show_field 'document_type1_ssim', label: 'Document Type'
    config.add_show_field 'document_type_ssim', label: 'Document Type'
    config.add_show_field 'employee_name_ssim', label: 'Employee Name'
    config.add_show_field 'fiscal_year_ssim', label: 'Fiscal Year'
    config.add_show_field 'function_ssim', label: 'Function'
    config.add_show_field 'granting_agency_ssim', label: 'Granting Agency'
    config.add_show_field 'item_status_ssim', label: 'Item Status'
    config.add_show_field 'multi_ssim', label: 'Multi'
    config.add_show_field 'node_ssim', label: 'Node'
    config.add_show_field 'position_ssim', label: 'Postion'
    config.add_show_field 'privacy_ssim', label: 'Privacy'
    config.add_show_field 'project_ssim', label: 'Project'
    config.add_show_field 'project_deliverable_ssim', label: 'Project Deliverable'
    config.add_show_field 'role_ssim', label: 'Role'
    config.add_show_field 'text_ssim', label: 'Description'
    config.add_show_field 'type_of_expense_ssim', label: 'Type of Expense'
    config.add_show_field 'type_of_grant_ssim', label: 'Type of Grant'
    config.add_show_field 'url_fulltext_ssm', label: 'URL'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    #config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
    #  field.solr_parameters = {
    #    'spellcheck.dictionary': 'title',
    #    qf: '${title_qf}',
    #    pf: '${title_pf}'
    #  }
    #end

    config.add_search_field('author') do |field|
      field.solr_parameters = {
        'spellcheck.dictionary': 'author',
        qf: '${author_qf}',
        pf: '${author_pf}'
      }
    end

    config.add_search_field('role') do |field|
      field.solr_parameters = {
        'spellcheck.dictionary': 'role',
        qf: '${role_qf}',
        pf: '${role_pf}'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('position') do |field|
      field.qt = 'search'
      field.solr_parameters = {
        'spellcheck.dictionary': 'position',
        qf: '${position_qf}',
        pf: '${position_pf}'
      }
    end

    config.add_search_field('client_name') do |field|
      field.solr_parameters = {
        'spellcheck.dictionary': 'client_name',
        qf: '${client_name_qf}',
        pf: '${client_name_pf}'
      }
    end

    config.add_search_field('document_type') do |field|
      field.solr_parameters = {
        'spellcheck.dictionary': 'document_type',
        qf: '${document_type_qf}',
        pf: '${document_type_pf}'
      }
    end

    #config.add_search_field('granting_agency') do |field|
    #  field.solr_parameters = {
    #    'spellcheck.dictionary': 'granting_agency',
    #    qf: '${granting_agency_qf}',
    #    pf: '${granting_agency_pf}'
    #  }
    #end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, qDate_ssim desc, author_ssim asc', label: 'relevance'
    config.add_sort_field 'qDate_ssim desc', label: 'date'
    #as author is multivalued and cannot be copied to a signle value field, sort on multi-authors is not sensible.
    #config.add_sort_field 'author_si asc, title_si asc', label: 'author'
    config.add_sort_field 'author_ssim asc', label: 'author'
    config.add_sort_field 'position_ssim asc', label: 'position'
    config.add_sort_field 'role_ssim asc', label: 'role'
    config.add_sort_field 'client_ssim asc', label: 'client'
    config.add_sort_field 'granting_agency_ssim asc', label: 'granting agency'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
    # if the name of the solr.SuggestComponent provided in your solrcongig.xml is not the
    # default 'mySuggester', uncomment and provide it below
    # config.autocomplete_suggester = 'mySuggester'
  end
end
