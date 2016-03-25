class Labeling < ActiveRecord::Base
 #stipulate that labeling is polymorphic and that it can mutate into different types of objects through lablelable
   belongs_to :labelable, polymorphic: true
   belongs_to :label
 end
