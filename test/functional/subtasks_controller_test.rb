# -*- encoding : utf-8 -*-
require 'test_helper'

class SubtasksControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get created" do
    get :created
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
