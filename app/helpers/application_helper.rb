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

    image_tag 'paid.png', size: '12x12', class: 'margin-left-5', title: 'Paid'
  end

  def point_booster_tag(user, match)
    return if match.blank?

    booster = user.point_booster_selected_for(match)
    return unless booster

    image_tag 'booster.png', size: '12x12', title: 'Points Booster'
  end

  def asset_present?(image_path)
    if Rails.env.production?
      Rails.application.assets_manifest.assets[image_path].present?
    else
      Rails.application.assets.resolve(image_path).present?
    end
  end

  def load_image(name)
    img_path = "#{@current_tournament_type}/#{@current_tournament_name}/#{name}"
    if asset_present?(img_path)
      img_path
    else
      "background/#{name}"
    end
  end

  def load_sign_in_image
    load_image('welcome3.jpg')
  end

  def load_welcome_image
    load_image(random_welcome_image)
  end

  def random_welcome_image
    # ['welcome.jpg', 'welcome2.jpg'].sample
    'welcome.jpg'
  end

  def load_login_image
    load_image('login.jpg')
  end

  def load_challenge_image
    load_image('login2.jpg')
  end

  def load_bg_image
    load_image('background.jpg')
  end
end
