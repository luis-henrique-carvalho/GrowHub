# frozen_string_literal: true

module Mentor
  module ExpertiseAreas
    class Filter < ApplicationOperation
      def call(params)
        set_params params

        define_query
        search

        success @query
      end

      private

      def define_query
        @query = ::Mentor::ExpertiseArea.all
      end

      def search
        return if @params[:search].blank?

        @query = @query.search(@params[:search])
      end
    end
  end
end
