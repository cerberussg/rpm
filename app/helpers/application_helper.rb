module ApplicationHelper
  def post_excerpt(post, length: 200)
    # Get plain text from rich text content
    plain_text = post.content.to_plain_text

    # Split by common code block indicators and take only the part before code
    parts = plain_text.split(/(?=class\s+\w+|def\s+\w+|function\s+\w+|const\s+\w+|let\s+\w+|var\s+\w+|import\s+|<\w+|{|}|\[|\])/)
    text_before_code = parts.first || plain_text

    # Truncate the clean text
    truncate(text_before_code.strip, length: length, separator: ' ')
  end
end
