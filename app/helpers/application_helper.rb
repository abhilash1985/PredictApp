# ApplicationHelper
module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end

  def amount_paid_tag(user, challenge)
    return if challenge.blank?
    paid = user.amount_paid_for(challenge)
    return unless paid
    image_tag 'paid.png', size: '12x12', class: 'margin-left-5'
  end

  def load_image(name)
    img_path = "#{@current_tournament_type}/#{@current_tournament_name}/#{name}"
    if Rails.application.assets.resolve(img_path).present?
      img_path
    else
      "background/#{name}"
    end
  end

  def load_sign_in_image
    load_image('sign_in.png')
  end

  def load_welcome_image
    load_image('welcome.jpg')
  end

  def load_login_image
    load_image('login.jpg')
  end

  def load_bg_image
    load_image('background.jpg')
  end
end
