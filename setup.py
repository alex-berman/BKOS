from setuptools import setup, find_packages
import pathlib

here = pathlib.Path(__file__).parent.resolve()

long_description = (here / "README.md").read_text(encoding="utf-8")

setup(
    name="bkos",
    version="1.0.0",
    description="Extensible explanatory dialogue system informed by theories of human argumentation, rhetoric and dialogue",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/alex-berman/BKOS-dev",
    author="Alex Berman",
    author_email="alexanander.berman@gu.se",
    packages=find_packages(),
    install_requires=open("requirements.txt").read().splitlines(),
    python_requires=">=3.9, <4",
    include_package_data=True,
    py_modules=["bkos.cli"],
    entry_points={
        "console_scripts": [
            "bkos=bkos.cli:main",
        ]
    },
)
