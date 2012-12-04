require 'test_helper'

class SonOfAnnotizersControllerTest < ActionController::TestCase
  setup do
    @son_of_annotizer = son_of_annotizers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:son_of_annotizers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create son_of_annotizer" do
    assert_difference('SonOfAnnotizer.count') do
      post :create, :son_of_annotizer => { :content => @son_of_annotizer.content, :name => @son_of_annotizer.name, :title => @son_of_annotizer.title }
    end

    assert_redirected_to son_of_annotizer_path(assigns(:son_of_annotizer))
  end

  test "should show son_of_annotizer" do
    get :show, :id => @son_of_annotizer
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @son_of_annotizer
    assert_response :success
  end

  test "should update son_of_annotizer" do
    put :update, :id => @son_of_annotizer, :son_of_annotizer => { :content => @son_of_annotizer.content, :name => @son_of_annotizer.name, :title => @son_of_annotizer.title }
    assert_redirected_to son_of_annotizer_path(assigns(:son_of_annotizer))
  end

  test "should destroy son_of_annotizer" do
    assert_difference('SonOfAnnotizer.count', -1) do
      delete :destroy, :id => @son_of_annotizer
    end

    assert_redirected_to son_of_annotizers_path
  end
end
