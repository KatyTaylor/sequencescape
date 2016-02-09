#This file is part of SEQUENCESCAPE is distributed under the terms of GNU General Public License version 1 or later;
#Please refer to the LICENSE and README files for information on licensing and authorship of this file.
#Copyright (C) 2015 Genome Research Ltd.
require "test_helper"

class QcReportTest < ActiveSupport::TestCase

  context "QcReport" do

    should belong_to :study
    should belong_to :product_criteria
    should have_many :qc_metrics
    should validate_presence_of :study
    should validate_presence_of :product_criteria
    # Also validates state, but we leave that off here as the state machine auto-populates it

  end

  context "A QcReport" do

    setup do
      @study = create :study
      @other_study = create :study
      @stock_plate = create :plate

      [@study,@other_study].each do |study|
        2.times do |i|
          @attribute = create :well_attribute, :measured_volume => 500, :concentration => 200
          sample = create(:study_sample, :study => study).sample
          well = create :well, :samples => [sample], :plate => @stock_plate, :map => create(:map, :location_id => i), :well_attribute => @attribute
          well.aliquots.each {|a| a.update_attributes!(:study => study) }
        end
      end

      @qc_report = create :qc_report, :study => @study
      @qc_metric_count = QcMetric.count
      @qc_report.generate!
    end

    should 'generate qc_metrics per sample' do
      assert_equal 2, QcMetric.count - @qc_metric_count
      assert_equal 2, @qc_report.qc_metrics.count
    end

    should 'assign a report identifier' do
      assert @qc_report.report_identifier.present?, "No identifier assigned"
      assert /wtccc_product[0-9]+_[0-9]{12}/ === @qc_report.report_identifier, "Unexpected identifier: #{@qc_report.report_identifier}"
    end

    should 'record the result of each qc' do
      @qc_report.qc_metrics.each do |metric|
        assert_equal 'passed', metric.qc_decision
        assert_equal nil, metric.proceed
        assert_equal({
          :total_micrograms => 100,
          :comment => ''
        }, metric.metrics)
      end
    end
  end

  context "QcReport state machine" do

    setup do
      @qc_report = create :qc_report
      # Stub out report generation as it advances the state machine
      @qc_report.stubs(:generate_report)
    end

    should 'follow expected state machine' do
      assert_equal 'queued', @qc_report.state
      @qc_report.generate!
      assert_equal 'generating', @qc_report.state
      @qc_report.generation_complete!
      assert_equal 'awaiting_proceed', @qc_report.state
      @qc_report.proceed_decision!
      assert_equal 'complete', @qc_report.state
    end
  end
end