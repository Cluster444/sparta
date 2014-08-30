class PlayerRegistration
  include ActiveModel::Model

  attr_accessor :name, :email, :password, :password_confirmation
  attr_reader :user, :player

  def initialize(params={})
    super
    @user = User.new email: email, password: password, password_confirmation: password_confirmation
    @player = Player.new name: name
  end

  def save
    if valid?
      @user.save!
      @player.save!
      true
    else
      false
    end
  end

  def valid?
    model_valid?(@user) & model_valid?(@player)
  end

  def model_valid?(model)
    if model.valid?
      true
    else
      model.errors.each do |attr,message|
        errors.add(attr,message)
      end
      false
    end
  end
end
