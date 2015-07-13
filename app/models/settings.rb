class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env

  # define separate booleans for pg and sqlite

  def sql_true
    Rails.env.production? ? "true" : "'t'"
  end

  def sql_false
    Rails.env.production? ? "false" : "'f'"
  end
end
