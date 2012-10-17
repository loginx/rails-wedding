class StaticController < ApplicationController
  StaticController::Pages = [:home, :events, :hotels]
  caches_page *StaticController::Pages
end
