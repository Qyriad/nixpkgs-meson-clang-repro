project(
  'nix-meson',
  'cpp',
  default_options : [
    'buildtype=debugoptimized',
    'b_lto=true',
    'warning_level=2',
    'cpp_std=c++20',
  ],
)

#deps = [
#  dependency('boost', include_type : 'system'),
#  dependency('nix-expr', include_type : 'system'),
#  dependency('nix-store', include_type : 'system'),
#  dependency('nix-main', include_type : 'system'),
#  dependency('argparse', include_type : 'system'),
#]

deps = []

srcs = [
  'src/main.cpp',
]

executable('main', srcs, dependencies : deps, install : true)
