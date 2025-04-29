# frozen_string_literal: true

module Mentor
  module Profile
    class Show < ApplicationOperation
      def call(model)
        success model
      end
    end
  end
end
