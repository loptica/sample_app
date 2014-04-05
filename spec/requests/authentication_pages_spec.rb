require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}

  describe "signin" do
    before {visit signin_path}

    describe "with invalid info" do
       before {click_button "Sign in"}
  	
  	  it {should have_content("Sign in")}
  	  it {should have_selector("div.alert.alert-error")}

  	  describe "after visiting another page" do
  	   before {click_link 'Home'}

  	   it {should_not have_selector('div.alert.alert-error')}

  	  end # od after
    end # od invalid info
  	describe "with valid info" do
      let(:user) {FactoryGirl.create(:user)}

      before do
      fill_in "Email",       with: user.email.upcase
      fill_in "Password",    with: user.password
      click_button "Sign in"
      end # od before

      it {should have_title(user.name)}
      it {should have_link('Profile',      href: user_path(user))}
      it {should have_link('Sign out',     href: signout_path)}
      it {should_not have_link('Sign in'), href: signin_path}

      describe "after saving the user" do
        before {click_button submit}

        let(:user) {User.find_by(email: 'user@example.com')}

        it {should have_link('Sign out')}
        it {should have_title(user.name)}
        it {should have_selector('div.alert.alert-success', text: 'Welcome')}
      end
    end
  end
end