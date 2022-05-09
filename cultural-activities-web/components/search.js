import { Input, DatePicker, Space, Select, Button } from 'antd';
import { SearchOutlined } from '@ant-design/icons';
import styles from "../styles/Home.module.css";
import useSWR from "swr";
import {fetcher} from "../lib/utils";
import {useState} from "react";
import  { map, isEmpty } from "lodash";

const { Option } = Select;

const Search = ({setSearchParams}) => {
  const [webSources, setWebSources] = useState([]);
  const [selectedWebSource, setSelectedWebSource] = useState(null)
  const [title, setTitle] = useState(null);


  const fetchWebSources = isEmpty(webSources) ? `${process.env.NEXT_PUBLIC_API_HOST}/web-sources` : null;
  useSWR(fetchWebSources, fetcher, {
    onSuccess: (data) => setWebSources(data.web_sources)
  });

  const onChange = () => {}
  const handleWebSourceChange = (value) => { setSelectedWebSource(value); };
  const handleTitleChange = ({ target: { value }}) => { setTitle(value); };

  const handleSearch = (event) => {
    event.preventDefault();
    const searchParams = {
      title,
      web_source: selectedWebSource
    };
    setSearchParams(searchParams);
  }

  return (
    <div className={styles.grid}>
      <div>
        <Input placeholder="Title" value={title} onChange={handleTitleChange} />
      </div>
      <div>
        <Space direction="vertical">
          <DatePicker onChange={onChange} placeholder="Select start date" />
        </Space>
      </div>
      <div>
        <Select style={{ width: 120 }} value={selectedWebSource} onSelect={handleWebSourceChange}>
          {
            map(webSources, ({id, name}) => (
              <Option key={id} value={id}>{name}</Option>
            ))
          }
        </Select>
      </div>
      <Button type="primary" icon={<SearchOutlined />} onClick={handleSearch}>
        Search
      </Button>
    </div>
  );
}

export default Search;