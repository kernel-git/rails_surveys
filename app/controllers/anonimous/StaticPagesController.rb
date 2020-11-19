class Anonimous::StaticPagesController < ApplicationController
  def login
    puts "Ping from anonimous/static_pages#login"
  end
  def recover_password
    puts "Ping from anonimous/static_pages#recover_password"
  end
  def contact_company
    puts "Ping from anonimous/static_pages#contact_company"
  end
  def contact_support
    puts "Ping from anonimous/static_pages#contact_support"
  end
  def faq
    puts "Ping from anonimous/static_pages#faq"
  end
  def privacy_policy
    puts "Ping from anonimous/static_pages#privacy_policy"
  end
  def not_found_404
    puts "Ping from anonimous/static_pages#not_found_404"
  end
end