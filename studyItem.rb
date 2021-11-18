class StudyItem
    attr_accessor :title, :category
    def initialize(title:, category:)
        @title = title
        @category = category
    end
end