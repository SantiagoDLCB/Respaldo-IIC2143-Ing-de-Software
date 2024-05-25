require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @report = reports(:one)
    @user = users(:another_user)
    sign_in @user
  end

  test "should get index" do
    get initiative_path(@report.initiative)
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count', 1) do
      post initiative_reports_path(@initiative), params: { report: { reason: "Test Reason", content: "Test Content" } }
    end
    assert_redirected_to initiative_path(@initiative)
    assert_equal 'Reporte creado exitosamente.', flash[:notice]
  end

  test "should not create report with invalid data" do
    assert_no_difference('Report.count') do
      post initiative_reports_path(@initiative), params: { report: { reason: nil, content: "Content" } }
    end
    assert_redirected_to initiative_path(@initiative)
    assert_equal 'Error al crear reporte.', flash[:alert]
  end

end