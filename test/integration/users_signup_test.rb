require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    
    #postした後にUser.countの値が変わらないことをテストする（userの作成に失敗する）
    assert_no_difference 'User.count' do
    post users_path, params: { user: { name:  "",
                                       email: "user@invalid",
                                       password:              "foo",
                                       password_confirmation: "bar" } }
    end
    
    assert_template 'users/new' #送信に失敗したときにnewアクションが再描画されるはず
    
    #エラーメッセージのテスト
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'div#error_explanation ul li',"Name can't be blank"
    assert_select 'div#error_explanation ul li',"Email is invalid"
    assert_select 'div#error_explanation ul li',"Password confirmation doesn't match Password"
    assert_select 'div#error_explanation ul li',"Password is too short (minimum is 6 characters)"
    
  end
  
  test "valid signup information" do
    get signup_path
    
    #User.countがpostに後に1増えていたらテストOK
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!  #指定されたリダイレクト先に移動するメソッド
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.empty?
    assert flash[:success] , "" #テストをパスする
  end
end
