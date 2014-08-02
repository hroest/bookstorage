require 'test_helper'

class BookTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_type" do
    assert_difference('BookType.count') do
      post :create, :book_type => { }
    end

    assert_redirected_to book_type_path(assigns(:book_type))
  end

  test "should show book_type" do
    get :show, :id => book_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => book_types(:one).to_param
    assert_response :success
  end

  test "should update book_type" do
    put :update, :id => book_types(:one).to_param, :book_type => { }
    assert_redirected_to book_type_path(assigns(:book_type))
  end

  test "should destroy book_type" do
    assert_difference('BookType.count', -1) do
      delete :destroy, :id => book_types(:one).to_param
    end

    assert_redirected_to book_types_path
  end
end
