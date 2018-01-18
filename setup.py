"""Minimal setup file for noble-pdf-service project."""

from setuptools import setup, find_packages

setup(
    name="noble_pdf_service",
    version="0.1.0",
    license="proprietary",
    description="PDF service on AWS Lambda",
    author="Noble Network of Charter Schools",
    url="https://github.com/noblenetworkcharterschools/comer-contact-notes",

    packages=find_packages(where="src"),
    package_dir={"": "src"},

    install_requires=[],
)
