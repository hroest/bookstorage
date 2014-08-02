require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, :book => {},
        :book_type => {:name => book_types(:one).id},
        :owner => {:name => owners(:one).id},
        :location => {:name => locations(:one).id},
        :language => {:name => languages(:one).id},
        :author => {:name => ""}
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should create book with author" do
    assert_difference('Book.count') do
      post :create, :book => {},
        :book_type => {:name => book_types(:one).id},
        :owner => {:name => owners(:one).id},
        :location => {:name => locations(:one).id},
        :language => {:name => languages(:one).id},
        :author => {:name => authors(:one).id.to_s}
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, :id => books(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => books(:one).to_param
    assert_response :success
  end

  test "should update book" do
    put :update, :id => books(:one).to_param, :book => { }, 
          :book_type => {:name => book_types(:one).id},
          :owner => {:name => owners(:one).id},
          :location => {:name => locations(:one).id},
          :language => {:name => languages(:one).id},
          :author => {:name => ""}
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, :id => books(:one).to_param
    end

    assert_redirected_to books_path
  end
end
