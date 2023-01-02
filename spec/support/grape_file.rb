# frozen_string_literal: true

module GrapeFile
  def roundup_relevant_cops(_filename)
    cops
  end

  RuboCop::Cop::Team.prepend self
end
