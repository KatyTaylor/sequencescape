# Used in {PacBioSequencingPipeline}, used to validate the CSVs that get generated
# to drive the machine. These files aren't compatible with the newer PacBIo machines though.
class ValidateSampleSheetTask < Task
  class ValidateSampleSheetData < Task::RenderElement
    def initialize(request)
      super(request)
    end
  end

  def create_render_element(request)
    request.asset && ValidateSampleSheetData.new(request)
  end

  def partial
    'validate_sample_sheet_batches'
  end

  def render_task(workflow, params)
    super
    workflow.render_validate_sample_sheet_task(self, params)
  end

  def do_task(workflow, params)
    workflow.do_validate_sample_sheet_task(self, params)
  end
end
