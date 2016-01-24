class CranController < ApplicationController
  def index
  	@packages = Package.all
  end
end
