class ResortsController < ApplicationController
    def index
      @resorts = Resort.includes(lifts: :trails).all
    end
  end
  