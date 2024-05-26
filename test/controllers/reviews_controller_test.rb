require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @review = reviews(:default_review)
    @user = users(:default_user)
    sign_in @user
  end

  test "should get index" do
    get event_path(@review.event)
    assert_response :success
  end

  test "should create review with valid data" do
    assert_difference('Review.count', 1) do
      post event_reviews_path(@event), params: { review: { calification: 5, content: "Great event!" } }
    end
    assert_redirected_to event_url(@event)
    assert_equal 'Reseña creada exitosamente.', flash[:notice]
  end

  test "should not create review if user already has one" do
    @event.reviews.create(calification: 4, content: "Awesome event!", user: @user)

    assert_no_difference('Review.count') do
      post event_reviews_path(@event), params: { review: { calification: 5, content: "Great event!" } }
    end
    assert_redirected_to event_url(@event)
    assert_equal 'No puedes crear dos reseñas para un mismo evento.', flash[:alert]
  end

end