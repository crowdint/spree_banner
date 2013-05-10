module Spree
  module BannerBoxesHelper

    def banner_box(params={})
      params[:category] ||= "home"
      params[:class] ||= "banner"
      params[:style] ||= "full"
      params[:list] ||= false
      params[:options] ||= {}
      @@banner = Spree::BannerBox.enable(params[:category])
      if @@banner.blank?
        return ''
      end
      res = []
      banner = @@banner.sort_by { |ban| ban.position }
        
      if (params[:list])
        #content_tag(:ul, banner.map{|ban| content_tag(:li, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe )
        render(:partial =>'spree/shared/banners_container', :layout => nil , :locals => { :banner => @@banner, :options => params[:options]}).to_s
      else
        #banner.map{|ban| content_tag(:div, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe
        ban = @@banner.offset(rand(@@banner.count)).first
        content_tag(:div, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])
      end
    end
    
  end
end
