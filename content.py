import os

def extract_flutter_contents(project_path, output_file):
    # Files to include outside lib folder
    special_files = ['.env', '.gitignore', 'pubspec.yaml', 'analysis_options.yaml']
    
    with open(output_file, 'w', encoding='utf-8') as outfile:
        # First process lib folder
        lib_path = os.path.join(project_path, 'lib')
        for root, _, files in os.walk(lib_path):
            for file in files:
                if file.endswith(('.dart', '.freezed.dart', '.g.dart')):
                    file_path = os.path.join(root, file)
                    relative_path = os.path.relpath(file_path, project_path)
                    
                    outfile.write(f"\n{'='*50}\n")
                    outfile.write(f"File: {relative_path}\n")
                    outfile.write(f"{'='*50}\n\n")
                    
                    try:
                        with open(file_path, 'r', encoding='utf-8') as infile:
                            outfile.write(infile.read())
                    except Exception as e:
                        outfile.write(f"Error reading file: {str(e)}\n")
        
        # Then process special files
        for special_file in special_files:
            file_path = os.path.join(project_path, special_file)
            if os.path.exists(file_path):
                outfile.write(f"\n{'='*50}\n")
                outfile.write(f"File: {special_file}\n")
                outfile.write(f"{'='*50}\n\n")
                
                try:
                    with open(file_path, 'r', encoding='utf-8') as infile:
                        outfile.write(infile.read())
                except Exception as e:
                    outfile.write(f"Error reading file: {str(e)}\n")

# Usage example
# Use either of these formats:
project_path = r"C:\Users\USER\smileatlas_app"  # Using raw string
# OR
# project_path = "C:\\Users\\USER\\smileatlas_app"  # Using escaped backslashes

output_file = "flutter_project_contents.txt"
extract_flutter_contents(project_path, output_file)