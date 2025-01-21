#!/bin/bash
#SBATCH --job-name=blender-job
#SBATCH --output=blender_jpn_%A_%a.out 
#SBATCH -p plgrid
#SBATCH -A plglscclass24-cpu
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=1GB
#SBATCH --array=1-100

module load blender

BLEND_FILE="file.blend"

# Set the output path where rendered frames or videos will be saved
OUTPUT_PATH="./blender_output/"   # Replace with your desired output directory

# Output format (e.g., 'FFMPEG' for video, 'PNG' for image sequence)
OUTPUT_FORMAT="PNG"

n=${SLURM_ARRAY_TASK_ID}

# Render the animation using Blender's command-line interface
blender -b "$BLEND_FILE" -o "${OUTPUT_PATH}frame_" -F "$OUTPUT_FORMAT" -f "$n"
 
# Notify completion
echo "Rendering completed. Check the output at $OUTPUT_PATH"