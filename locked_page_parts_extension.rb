# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class LockedPagePartsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/locked_page_parts"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :page_parts, :member => { :lock => :post, :unlock => :post }
    end
  end
  
  def activate
    # extend parts controller with lock and unlock methods;
    Admin::PagePartsController.class_eval do
      include PagePartsControllerExtensions
    end
    
    admin.page.edit.add :part_controls, 'lock_page_part'
    admin.page.edit.add :main, 'locked_page_style'
  end
  
  def deactivate
    # admin.tabs.remove "Locked Page Parts"
  end
  
end
