# Use the latest Debian as the base image
FROM debian:latest

# Update the package list and upgrade all packages
RUN apt update && apt upgrade -y

# Install necessary packages, including python3-venv for virtual environments
RUN apt install -y git curl python3-pip python3-venv

# Create a directory for the app
RUN mkdir /app/
WORKDIR /app/

# Copy the current directory contents into the container at /app
COPY . /app/

# Create and activate a virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Upgrade pip in the virtual environment
RUN pip install --upgrade pip

# Install the dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install Flask

EXPOSE 8000
# Set the default command to run your application
CMD ["python3", "main.py"]
