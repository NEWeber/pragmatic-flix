class ApplicationController < ActionController::Base
  add_flash_types(:danger) # registers danger as a flash type that can now be used and styled
end
