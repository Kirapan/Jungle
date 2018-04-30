require 'rails_helper'


RSpec.describe User, type: :model do

  describe 'Validations' do
    it {is_expected.to validate_presence_of (:password)}
    it {is_expected.to validate_presence_of (:password_confirmation)}
    it {is_expected.to validate_presence_of (:email)}
    it {should validate_uniqueness_of(:email).case_insensitive}
    it { should validate_length_of(:password).is_at_least(6) }
    it {is_expected.to validate_presence_of (:first_name)}
    it {is_expected.to validate_presence_of (:last_name)}

    it "should return invald if password and password_confirmation don't match" do
      @user = User.new({first_name: 'becker', last_name: 'fillipe', email: 'CC@gmail.com'})
      @user.password = "password"
      @user.password_confirmation = "notapassword"
      expect(@user).to be_invalid
    end

    it "should return invalid if email(case case insensitive) already exists in the database" do
      @user = User.create!({first_name: 'becker', last_name: 'fillipe', email: 'cc@gmail.com',password:'password',password_confirmation:'password'})
      @user2 = User.new({first_name: 'becker', last_name: 'fillipe', email: 'CC@gmail.com',password:'password',password_confirmation:'password'})
      expect(@user2).to be_invalid
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = FactoryBot.create(:user)
    end

    context "when email and password are correct"
    it "should return @user " do
      expect(User.authenticate_with_credentials('ab@gmail.com','1234567')).to eq(@user)
    end
    it "should return @user when email is in capital letters" do
      expect(User.authenticate_with_credentials('Ab@gmail.Com','1234567')).to eq(@user)
    end
    it "should return @user when there are spaces before/after email" do
      expect(User.authenticate_with_credentials('  Ab@gmail.Com ','1234567')).to eq(@user)
    end

    context "when either email and password is not correct"
    it "should return nil if email does not exist in database" do
      expect(User.authenticate_with_credentials('dd@gmail.com','1234567')).to be_nil
    end
    it "should return nil if password does not match with password in database" do
      expect(User.authenticate_with_credentials('ab@gmail.com','1111111')).to be_nil
    end

  end
end
