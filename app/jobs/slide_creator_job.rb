class SlideCreatorJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    sections = Section.where(course_id: course_id).order(:id)
    Slide.where(course_id: course_id).delete_all
    course = Course.find_by(id: course_id)
    toc = JSON.parse(course.toc)
    page_number = 0
    chapter = {}
    sub_chapter_index = 0
    sub_chapter_title = ""
    current_indicator = ""

    slides_data = sections.flat_map do |section|
      page_number += 1
      case section.role
      when "h1"
        [
          {
            course_id: course.id,
            template_name: "T1",
            page_number:,

            # TODO: (this is only temporal)
            prompt: "You're a teacher, generate an opening of this new course.",
            text_for_display: {
              productionDate: course.production_date,
              author: course.author,
              courseTitle: section.raw
            }.to_json
          }
        ]
      when "h2"
        chapter = get_chapter(toc, section.raw)
        sub_chapter_index = 0
        current_indicator = "#{chapter['chapterIndex']} #{chapter['chapterTitle']}"
        result = [
          {
            course_id: course.id,
            template_name: "T2",
            page_number:,
            prompt: "You're a teacher, generate a chapter introduction of this new course.",
            text_for_display: {
              chapterTitle: section.raw,
              chapterIndex: chapter["chapterIndex"]
            }.to_json
          }
        ]

        # insert a T3 slide, only if there are more than 1 sub-chapters
        if chapter["subChapters"].length > 1
          page_number += 1
          result.push(
            {
              course_id: course.id,
              template_name: "T3",
              page_number:,
              prompt: "You're a teacher, generate a introduction of following sub-chapters.",
              text_for_display: {
                subChapters: chapter["subChapters"],
                chapterIndex: chapter["chapterIndex"]
              }.to_json
            }
          )
        end
        result
      when "h3"
        page_number -= 1
        sub_chapter_title = chapter["subChapters"][sub_chapter_index]
        sub_chapter_index += 1
        current_indicator = "#{chapter['chapterIndex']}.#{sub_chapter_index} #{sub_chapter_title}"
        []
      when "body"
        body = ""
        if sub_chapter_index == 1
          body += "### #{sub_chapter_title}\n\n"
        end
        [
          {
            course_id: course.id,
            template_name: "T4",
            page_number:,
            indicator: current_indicator,
            prompt: "You're a teacher, highlight important knowledge of this section.",
            text_for_display: {
              body: body + section.raw
            }.to_json
          }
        ]
      end
    end

    page_number += 1
    slides_data.push(
      {
        course_id: course.id,
        template_name: "T6",
        page_number:,
        prompt: "You're a teacher, the course ends here, say bye to students.",
        text_for_display: {
          sourceUrl: course.link
        }.to_json
      }
    )
    # logger.info "\n\n\n->->! #{slides_data}"
    # slides_data.each do |data|
    #   logger.info "\n\n\n ->-> #{data.to_json}"
    #   # Slide.create!(data)
    # end

    Slide.transaction do
      slides_data.each do |data|
        # logger.info "\n\n\n ->-> #{data.to_json}"
        Slide.create!(data)
      end
    end
  end

  private

  def get_chapter(chapters, chapter_title)
    chapters.each do |chapter|
      if chapter["chapterTitle"] == chapter_title
        return chapter
      end
    end
  end
end
