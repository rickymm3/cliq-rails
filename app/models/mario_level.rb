class MarioLevel < ActiveRecord::Base
  belongs_to :l_category
  has_many :mario_ratings
  belongs_to :user
  has_many :mario_user_comments

  validates :name, :description, :l_category_id, :level_code, presence: true
  validates_uniqueness_of :level_code
  validates_length_of :level_code, minimum: 16, maximum: 19

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
              available_filters: [
                :sorted_by,
                :search_query,
                :with_l_category_id
              ]

  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
     (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 1
    where(
       terms.map {
         or_clauses = [
             "LOWER(mario_levels.name) LIKE ?"
         ].join(' OR ')
         "(#{ or_clauses })"
       }.join(' AND '),
       *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("mario_levels.created_at #{ direction }")
      when /^name_/
        order("LOWER(mario_levels.name) #{ direction }")
      when /^fun_rank_/
        order("LOWER(maior_levels.fun_rank) #{ direction }").includes(:country)
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_l_category_id, lambda { |l_category_ids|
    where(l_category_id: [*l_category_ids])
  }

  def self.options_for_sorted_by
    [
        ['Name', 'name_asc'],
        ['Uploaded (newest)', 'created_at_asc'],
        ['Uploaded (oldest)', 'created_at_desc']
    ]
  end

end
