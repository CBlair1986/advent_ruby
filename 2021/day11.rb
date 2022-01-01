# frozen_string_literal: true

input = File.read('input/day11.txt')
            .lines
            .map(&:strip)
            .map(&:chars)
            .map { |chars| chars.map(&:to_i) }

## Grid will handle the grid, obviously
class Grid
  def initialize(grid)
    @grid = grid
    @height = grid.length
    @width = grid.first.length
  end

  def at(xloc, yloc)
    @grid[yloc][xloc]
  end

  def ortho_neighbors(xloc, yloc)
    # Returns the orthographic (n,s,e,w) neighbors
  end

  def diag_neighbors(xloc, yloc)
    # Returns the diagonal (ne, nw, se, sw) neighbors
  end

  def neighbors(xloc, yloc)
    # Returns both the diagonal and orthographic neighbors
    ortho_neighbors(xloc, yloc) | diag_neighbors(xloc, yloc)
  end
end

g = Grid.new(input)
