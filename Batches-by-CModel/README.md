All the examples in this sample data set can be ingested via islandora batch at one time by running the `ingest_samples.sh` script from the command line.

## Module Dependencies
All of the following islandora modules need to be installed and enabled to run this script. 

- [islandora_batch_with_derivs](https://github.com/mjordan/islandora_batch_with_derivs): this is used to create the "ICG Samples" collection, and the newspaper.
- [islandora_batch](https://github.com/Islandora/islandora_batch): this is used for the audio, basic image, large image, pdf and video content.
- [islandora_book_batch](https://github.com/Islandora/islandora_book_batch): this is used for ingesting books and their pages.
- [islandora_newspaper_batch](https://github.com/Islandora/islandora_newspaper_batch): this is used for ingesting newspaper issues and their pages.
- [islandora_compound_batch](https://github.com/MarcusBarnes/islandora_compound_batch): this is used for ingesting compound objects and their children.

## Usage

- The entire `Batches-by-CModel` directory needs to be copied to a location that is accessible on the web server, with read permissions suitable for the user who will be running the script.
- The location of the `ingest_samples.sh` script with respect to this directory should be preserved, since it expects to find the sample files relative to its own location.
- To run the sample ingest, run the script in the shell, providing as an argument the path to the drupal root. E.g.
```bash
sh /path/to/icg_samples/Batches-by-CModel/ingest_samples.sh /var/www/html
```
- Because several of these ingests use islandora's derivative generation, it may take some minutes to complete. The terminal will display batch ingest progress information.

## Notes
- If you prefer to ingest individual content model sample folders, consult the README.md files within each content model folder for instructions.
- All the samples depend on first ingesting the "ICG Samples" collection (`samples:collection`). This is accomplished by first ingesting the contents of the "Collections" folder.
- The "newspaperissues" samples depend on first ingesting the "Newspaper" sample (which itself depends on first installing the "Collections").
- The "Collections" and "Newspaper" samples create objects with fixed PIDs. Therefore, they can only be

## Maintainers/Sponsors
- [Born-Digital](http://born-digital.com)

## To do
- Pre-derive all derivatives and use only [islandora_batch_with_derivs](https://github.com/mjordan/islandora_batch_with_derivs). This will speed things up tremendously, at the expense of a somewhat larger set of sample files.

## Development
- Pull request are welcome, as are use cases and suggestions.

## License
- Sample content was sourced from public domain collections hosted by [archive.org](http://archive.org) and the Library of Congress. Consult the MODS records on individual objects for details.
- [GPLv3](https://www.gnu.org/licenses/gpl-3.0.txt) 