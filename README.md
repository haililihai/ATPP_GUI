              _     _________  _______  _______
             / \   |  _   _  ||_   __ \|_   __ \
            / _ \  |_/ | | \_|  | |__) | | |__) |
           / ___ \     | |      |  ___/  |  ___/
         _/ /   \ \_  _| |_    _| |_    _| |_
        |____| |____||_____|  |_____|  |_____|

## ATPP GUI version
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.239705.svg)](https://doi.org/10.5281/zenodo.239705)

ATPP (Automatic Tractography-based Parcellation Pipeline)

- Single-ROI oriented brain parcellation
- Automatic parallel computing
- Modular and flexible structure
- Simple and easy-to-use settings

## Installation
1. Install build tools.

   For RedHat/CentOS:

   ```shell
   sudo yum groupinstall 'Development Tools'
   ```

   For Debian/Ubuntu/Mint:

   ```shell
   sudo apt-get install build-essential
   ```

2. Install ffcall (already included in the repository):

   ```shell
   cd ffcall-1.10
   ./configure; make; sudo make install
   ```

3. Install GTK2 backend:

   For RedHat/CentOS:

   ```shell
   sudo yum install gtk2-devel
   ```

   For Debian/Ubuntu/Mint:

   ```shell
   sudo apt-get install libgtk2.0-dev
   ```

4. Install gtk-server (already included in the repository):

   ```shell
   cd gtk-server-2.3.1-sr
   ./configure; make; sudo make install
   ```

5. Finally, run ATPP:

   ```
   ./ATPP &
   ```


## Prerequisites:
===============================================

- Tools:
    - FSL (with FDT toolbox), SGE and MATLAB (with SPM8)
    - gtk-server and ffcall libraries, which have been included in this repository
- Data files:
    - T1 image for each subject
    - b0 image for each subject
    - images preprocessed by FSL(BedpostX) for each subject
- Directory structure:
```
     Working_dir
     |-- sub1
     |   |-- T1_sub1.nii
     |   |-- b0_sub1.nii
     |-- ...
     |-- subN
     |   |-- T1_subN.nii
     |   |-- b0_subN.nii
     |-- ROI
     |   |-- ROI_L.nii
     |   `-- ROI_R.nii
     `-- log 
```
===============================================

