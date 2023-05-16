#. conda/etc/profile.d/conda.sh

#initially do this
wget "https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh" -O miniconda.sh -q
sh miniconda.sh -b -p ./conda
rm miniconda.sh
. conda/etc/profile.d/conda.sh
find conda/ -follow -type f -name '*.a' -delete
find conda/ -follow -type f -name '*.js.map' -delete
conda/bin/conda clean -afy
conda env update -n base --file environment.yml
conda activate base
