module Sequel
  module Instruments
    module ::Sequel
      class Database
        def log_yield(sql, args=nil)
          sql = "#{sql}; #{args}" if args
          Slides.log :instrumentation, action: action(sql), sql: sql do
            begin
              yield
            rescue => e
              Slides.log :database_error, exception: e.class.name, 
                message: e.message, sql: sql, backtrace: e.backtrace
              raise
            end
          end
        end

        private

        def action(sql)
          sql[/(\w+){1}/].upcase
        end
      end
    end
  end
end
