# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'
# require 'action_view/helpers'
# include ActionView::Helpers::DateHelper

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS = ['gray', 'ginger', 'black', 'calico', 'tabby', 'white']

    validates :birth_date, :color, :name, :sex, presence: true
    validates :color, inclusion: { in: CAT_COLORS }
    validates :sex, inclusion: { in: ["M", "F"] }
    validate :birth_date_cannot_be_in_the_future

    def birth_date_cannot_be_in_the_future
        if birth_date.present? && birth_date.to_date > Date.today
            errors.add(:birth_date)
        end
    end

    def age
        age = time_ago_in_words(birth_date)
        age.split(" ")[1..-1].join(" ")
    end

end
